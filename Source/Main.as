bool g_visible = true;
float g_dt = 0;
Dashboard@ g_dashboard;

nvg::Font g_font;
nvg::Font g_fontBold;

void RenderMenu()
{
	if (UI::MenuItem("\\$9f3" + Icons::BarChart + "\\$z Dashboard", "", g_visible)) {
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

void Update(float dt)
{
	// We need to save this for the Accelerometer:
	// Specifically to get an accurate acceleration value in meters per second per second.
	// Without this dt we can only get a fake 'acceleration' that doesn't incorporate time properly.
	g_dt = dt;
}

void OnSettingsChanged()
{
	g_dashboard.OnSettingsChanged();
}

void Main()
{
	auto app = GetApp();

	g_font = nvg::LoadFont("DroidSans.ttf", true);
	g_fontBold = nvg::LoadFont("DroidSans-Bold.ttf", true);

	@g_dashboard = Dashboard();

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
}
