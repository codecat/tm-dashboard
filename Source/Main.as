bool g_visible = true;
Dashboard@ g_dashboard;

Resources::Font@ g_font;
Resources::Font@ g_fontBold;
Resources::Font@ g_fontIcons;

void RenderMenu()
{
	if (UI::MenuItem("\\$9f3" + Icons::Stopwatch + "\\$z Dashboard", "", g_visible)) {
		g_visible = !g_visible;
	}
}

void Render()
{
	if (!g_visible) {
		return;
	}

	// Render dashboard
	if (g_dashboard !is null) {
		g_dashboard.Render();
	}
}

void RenderInterface()
{
#if !COMPETITION
	if (Setting_General_MovePad) {
		Locator::Render("Controller/pad", Setting_General_PadPos, Setting_General_PadSize);
		Setting_General_PadPos = Locator::GetPos();
		Setting_General_PadSize = Locator::GetSize();
	}

	if (Setting_General_MoveGearbox) {
		Locator::Render("Gearbox", Setting_General_GearboxPos, Setting_General_GearboxSize);
		Setting_General_GearboxPos = Locator::GetPos();
		Setting_General_GearboxSize = Locator::GetSize();
	}

	if (Setting_General_MoveWheels) {
		Locator::Render("Overview", Setting_General_WheelsPos, Setting_General_WheelsSize);
		Setting_General_WheelsPos = Locator::GetPos();
		Setting_General_WheelsSize = Locator::GetSize();
	}
#endif

	if (Setting_General_MoveSpeed) {
		Locator::Render("Speed", Setting_General_SpeedPos, Setting_General_SpeedSize);
		Setting_General_SpeedPos = Locator::GetPos();
		Setting_General_SpeedSize = Locator::GetSize();
	}
}

void OnSettingsChanged()
{
	g_dashboard.OnSettingsChanged();
}

void Main()
{
	auto app = GetApp();

	@g_font = Resources::GetFont("DroidSans.ttf");
	@g_fontBold = Resources::GetFont("DroidSans-Bold.ttf");
	@g_fontIcons = Resources::GetFont("fa-solid.ttf");

	nvg::AddFallbackFont(g_font, g_fontIcons);
	nvg::AddFallbackFont(g_fontBold, g_fontIcons);

	@g_dashboard = Dashboard();

#if !COMPETITION
	while (true) {
		// Find the most recently used pad
		CInputScriptPad@ mostRecentPad;

		for (uint i = 0; i < app.InputPort.Script_Pads.Length; i++) {
			auto pad = app.InputPort.Script_Pads[i];
			if (mostRecentPad is null || pad.IdleDuration < mostRecentPad.IdleDuration) {
				@mostRecentPad = pad;
				if (pad.IdleDuration == 0) {
					break;
				}
			}
		}

		if (mostRecentPad is null) {
			// Clear pad if there is none found
			g_dashboard.ClearPad();
		} else {
			// Force a pad type if the settings demand it
			auto padType = mostRecentPad.Type;
			switch (Setting_General_ForcePadType) {
				case ForcePadType::Gamepad: padType = CInputScriptPad::EPadType::XBox; break;
				case ForcePadType::Keyboard: padType = CInputScriptPad::EPadType::Keyboard; break;
			}

			g_dashboard.SetPad(padType);
		}

		yield();
	}
#endif
}
