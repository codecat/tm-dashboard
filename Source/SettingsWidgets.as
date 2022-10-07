bool g_settingsMove = false;

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
		if (UI::BeginTable("Widgets", 3)) {
			UI::TableSetupColumn("Widget", UI::TableColumnFlags::WidthStretch, 0.9f);
			UI::TableSetupColumn("Visible UI", UI::TableColumnFlags::WidthFixed, 100);
			UI::TableSetupColumn("Hidden UI", UI::TableColumnFlags::WidthFixed, 100);
			UI::TableHeadersRow();

			UI::TableNextColumn();
			UI::Text("Controller/pad");
			UI::TableNextColumn();
			Setting_General_ShowPad = UI::Checkbox("##ControllerPad-Visible", Setting_General_ShowPad);
			UI::TableNextColumn();
			Setting_General_ShowPadHidden = UI::Checkbox("##ControllerPad-Hidden", Setting_General_ShowPadHidden);

			UI::TableNextColumn();
			UI::Text("Gearbox");
			UI::TableNextColumn();
			Setting_General_ShowGearbox = UI::Checkbox("##Gearbox-Visible", Setting_General_ShowGearbox);
			UI::TableNextColumn();
			Setting_General_ShowGearboxHidden = UI::Checkbox("##Gearbox-Hidden", Setting_General_ShowGearboxHidden);

			UI::TableNextColumn();
			UI::Text("Wheels");
			UI::TableNextColumn();
			Setting_General_ShowWheels = UI::Checkbox("##Wheels-Visible", Setting_General_ShowWheels);
			UI::TableNextColumn();
			Setting_General_ShowWheelsHidden = UI::Checkbox("##Wheels-Hidden", Setting_General_ShowWheelsHidden);

			UI::TableNextColumn();
			UI::Text("Acceleration");
			UI::TableNextColumn();
			Setting_General_ShowAcceleration = UI::Checkbox("##Acceleration-Visible", Setting_General_ShowAcceleration);
			UI::TableNextColumn();
			Setting_General_ShowAccelerationHidden = UI::Checkbox("##Acceleration-Hidden", Setting_General_ShowAccelerationHidden);

			UI::TableNextColumn();
			UI::Text("Speed");
			UI::TableNextColumn();
			Setting_General_ShowSpeed = UI::Checkbox("##Speed-Visible", Setting_General_ShowSpeed);
			UI::TableNextColumn();
			Setting_General_ShowSpeedHidden = UI::Checkbox("##Speed-Hidden", Setting_General_ShowSpeedHidden);

			UI::EndTable();
		}

		UI::Separator();
		UI::TextWrapped("In the above table, select which widgets you want to display when the game UI is visible, and when the game UI is hidden. Note that this requires the option \"Hide overlay on hidden game UI\" under \"General\" to be disabled!");

	} else {
		Setting_General_ShowPadHidden = Setting_General_ShowPad = UI::Checkbox("Controller/pad", Setting_General_ShowPad);
		Setting_General_ShowGearboxHidden = Setting_General_ShowGearbox = UI::Checkbox("Gearbox", Setting_General_ShowGearbox);
		Setting_General_ShowWheelsHidden = Setting_General_ShowWheels = UI::Checkbox("Wheels", Setting_General_ShowWheels);
		Setting_General_ShowAccelerationHidden = Setting_General_ShowAcceleration = UI::Checkbox("Acceleration", Setting_General_ShowAcceleration);
		Setting_General_ShowSpeedHidden = Setting_General_ShowSpeed = UI::Checkbox("Speed", Setting_General_ShowSpeed);
	}
}

void RenderInterface()
{
	if (g_settingsMove) {
		bool visiblePad          = UI::IsGameUIVisible() ? Setting_General_ShowPad          : Setting_General_ShowPadHidden;
		bool visibleGearbox      = UI::IsGameUIVisible() ? Setting_General_ShowGearbox      : Setting_General_ShowGearboxHidden;
		bool visibleWheels       = UI::IsGameUIVisible() ? Setting_General_ShowWheels       : Setting_General_ShowWheelsHidden;
		bool visibleAcceleration = UI::IsGameUIVisible() ? Setting_General_ShowAcceleration : Setting_General_ShowAccelerationHidden;
		bool visibleSpeed        = UI::IsGameUIVisible() ? Setting_General_ShowSpeed        : Setting_General_ShowSpeedHidden;

		if (visiblePad) {
			Locator::Render("Controller/pad", Setting_General_PadPos, Setting_General_PadSize);
			Setting_General_PadPos = Locator::GetPos();
			Setting_General_PadSize = Locator::GetSize();
		}

		if (visibleGearbox) {
			Locator::Render("Gearbox", Setting_General_GearboxPos, Setting_General_GearboxSize);
			Setting_General_GearboxPos = Locator::GetPos();
			Setting_General_GearboxSize = Locator::GetSize();
		}

		if (visibleWheels) {
			Locator::Render("Wheels", Setting_General_WheelsPos, Setting_General_WheelsSize);
			Setting_General_WheelsPos = Locator::GetPos();
			Setting_General_WheelsSize = Locator::GetSize();
		}

		if (visibleAcceleration) {
			Locator::Render("Acceleration", Setting_General_AccelerationPos, Setting_General_AccelerationSize);
			Setting_General_AccelerationPos = Locator::GetPos();
			Setting_General_AccelerationSize = Locator::GetSize();
		}

		if (visibleSpeed) {
			Locator::Render("Speed", Setting_General_SpeedPos, Setting_General_SpeedSize);
			Setting_General_SpeedPos = Locator::GetPos();
			Setting_General_SpeedSize = Locator::GetSize();
		}
	}

	g_settingsMove = false;
}
