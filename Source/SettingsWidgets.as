bool g_settingsMove = false;

[SettingsTab name="Widgets"]
void RenderSettingsWidgets()
{
	g_settingsMove = true;

	UI::TextWrapped("While this tab is open, you can drag the widgets around, resize them, and toggle them on and off.");

	Setting_General_ShowPad = UI::Checkbox("Controller/pad", Setting_General_ShowPad);
	Setting_General_ShowGearbox = UI::Checkbox("Gearbox", Setting_General_ShowGearbox);
	Setting_General_ShowWheels = UI::Checkbox("Wheels", Setting_General_ShowWheels);
	Setting_General_ShowAcceleration = UI::Checkbox("Acceleration", Setting_General_ShowAcceleration);
	Setting_General_ShowSpeed = UI::Checkbox("Speed", Setting_General_ShowSpeed);
}

void RenderInterface()
{
	if (g_settingsMove) {
		if (Setting_General_ShowPad) {
			Locator::Render("Controller/pad", Setting_General_PadPos, Setting_General_PadSize);
			Setting_General_PadPos = Locator::GetPos();
			Setting_General_PadSize = Locator::GetSize();
		}

		if (Setting_General_ShowGearbox) {
			Locator::Render("Gearbox", Setting_General_GearboxPos, Setting_General_GearboxSize);
			Setting_General_GearboxPos = Locator::GetPos();
			Setting_General_GearboxSize = Locator::GetSize();
		}

		if (Setting_General_ShowWheels) {
			Locator::Render("Wheels", Setting_General_WheelsPos, Setting_General_WheelsSize);
			Setting_General_WheelsPos = Locator::GetPos();
			Setting_General_WheelsSize = Locator::GetSize();
		}

		if (Setting_General_ShowAcceleration) {
			Locator::Render("Acceleration", Setting_General_AccelerationPos, Setting_General_AccelerationSize);
			Setting_General_AccelerationPos = Locator::GetPos();
			Setting_General_AccelerationSize = Locator::GetSize();
		}

		if (Setting_General_ShowSpeed) {
			Locator::Render("Speed", Setting_General_SpeedPos, Setting_General_SpeedSize);
			Setting_General_SpeedPos = Locator::GetPos();
			Setting_General_SpeedSize = Locator::GetSize();
		}
	}

	g_settingsMove = false;
}
