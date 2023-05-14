bool g_settingsMove = false;
UI::Cond g_settingsMoveCond = UI::Cond::Appearing;

[Setting hidden]
bool Setting_AdvancedWidgetSettings = false;

[SettingsTab name="Widgets" icon="ArrowsAlt"]
void RenderSettingsWidgets()
{
	g_settingsMove = true;

	UI::TextWrapped("While this tab is open, you can drag the widgets around, resize them, and toggle them on and off.");

	Setting_AdvancedWidgetSettings = UI::Checkbox("Advanced visibility settings", Setting_AdvancedWidgetSettings);

	UI::Separator();

	if (Setting_AdvancedWidgetSettings) {
		if (UI::BeginTable("Widgets", 5)) {
			UI::TableSetupColumn("Widget", UI::TableColumnFlags::WidthStretch, 0.9f);
			UI::TableSetupColumn("Position", UI::TableColumnFlags::WidthFixed, 130);
			UI::TableSetupColumn("Size", UI::TableColumnFlags::WidthFixed, 130);
			UI::TableSetupColumn("Visible UI", UI::TableColumnFlags::WidthFixed, 80);
			UI::TableSetupColumn("Hidden UI", UI::TableColumnFlags::WidthFixed, 80);
			UI::TableHeadersRow();

			for (uint i = 0; i < g_dashboard.m_things.Length; i++) {
				auto thing = g_dashboard.m_things[i];

				UI::PushID(thing);

				UI::TableNextColumn();
				UI::Text(thing.m_name);

				UI::TableNextColumn();
				UI::PushItemWidth(-1);
				thing.m_pos = UI::InputFloat2("##Position", thing.m_pos);
				UI::PopItemWidth();

				UI::TableNextColumn();
				UI::PushItemWidth(-1);
				thing.m_size = UI::InputFloat2("##Size", thing.m_size);
				UI::PopItemWidth();

				UI::TableNextColumn();
				bool whenVisible = UI::Checkbox("##WhenVisible", thing.IsVisible(false));

				UI::TableNextColumn();
				bool whenHidden = UI::Checkbox("##WhenHidden", thing.IsVisible(true));

				thing.SetVisible(whenVisible, whenHidden);
				thing.SetProportions(thing.m_pos, thing.m_size);

				UI::PopID();
			}

			UI::EndTable();
		}

		UI::Separator();
		UI::TextWrapped("In the above table, select which widgets you want to display when the game UI is visible, and when the game UI is hidden. Note that this requires the option \"Hide overlay on hidden game UI\" under \"General\" to be disabled!");

	} else {
		for (uint i = 0; i < g_dashboard.m_things.Length; i++) {
			auto thing = g_dashboard.m_things[i];
			bool visible = UI::Checkbox(thing.m_name, thing.IsVisible(false));
			thing.SetVisible(visible, visible);
		}
	}

	UI::Separator();
	if (UI::Button("Reset proportions to defaults")) {
		for (uint i = 0; i < g_dashboard.m_things.Length; i++) {
			auto thing = g_dashboard.m_things[i];
			thing.ResetProportions();
			thing.UpdateProportions();
		}

		// This is required to force the locator windows to reset on the next frame, rather than use the same positions from the last frame
		g_settingsMoveCond = UI::Cond::Always;
	}
}

void RenderInterface()
{
	if (!g_settingsMove) {
		return;
	}

	float scale = UI::GetScale();

	for (uint i = 0; i < g_dashboard.m_things.Length; i++) {
		auto thing = g_dashboard.m_things[i];
		if (!thing.IsVisible(true) && !thing.IsVisible(false)) {
			continue;
		}

		thing.UpdateProportions();

		vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
		vec2 pos = thing.m_pos * (screenSize - thing.m_size);

		UI::SetNextWindowSize(int(thing.m_size.x), int(thing.m_size.y), g_settingsMoveCond);
		UI::SetNextWindowPos(int(pos.x), int(pos.y), g_settingsMoveCond);

		UI::Begin(Icons::ArrowsAlt + " " + thing.m_name, UI::WindowFlags::NoCollapse | UI::WindowFlags::NoSavedSettings);
		thing.m_size = UI::GetWindowSize() / scale;
		thing.m_pos = UI::GetWindowPos() / scale / (screenSize - thing.m_size);
		UI::End();

		thing.SetProportions(thing.m_pos, thing.m_size);
	}

	g_settingsMove = false;
	g_settingsMoveCond = UI::Cond::Appearing;
}
