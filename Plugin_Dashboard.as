#name "Dashboard"
#author "Miss"
#category "Overlay"

#siteid 103
#version "1.1"

#max_game_version "2021-05-20"

#include "Icons.as"

#include "Dashboard/Settings.as"

#include "Dashboard/Helpers/SceneVis.as"
#include "Dashboard/Helpers/Vehicle.as"
#include "Dashboard/Helpers/Locator.as"

#include "Dashboard/Thing.as"

#include "Dashboard/Pads/Keyboard.as"
#include "Dashboard/Pads/Gamepad.as"

#include "Dashboard/Things/Gearbox.as"
#include "Dashboard/Things/Speed.as"
#include "Dashboard/Things/Wheels.as"

bool g_visible = true;
Dashboard@ g_dashboard;

Resources::Font@ g_font;
Resources::Font@ g_fontBold;
Resources::Font@ g_fontIcons;

class Dashboard
{
	EPadType m_currentPadType = EPadType(-1);

	DashboardThing@ m_pad;
	DashboardGearbox@ m_gearbox;
	DashboardSpeed@ m_speed;
	DashboardWheels@ m_wheels;

	Dashboard()
	{
		@m_gearbox = DashboardGearbox();
		@m_speed = DashboardSpeed();
		@m_wheels = DashboardWheels();
	}

	CSmPlayer@ GetViewingPlayer()
	{
		auto playground = GetApp().CurrentPlayground;
		if (playground is null || playground.GameTerminals.Length != 1) {
			return null;
		}
		return cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
	}

	void ClearPad()
	{
		m_currentPadType = EPadType(-1);
		@m_pad = null;
	}

	void SetPad(EPadType type)
	{
		if (m_currentPadType == type) {
			return;
		}
		m_currentPadType = type;

		switch (type) {
			case EPadType::Keyboard:
				@m_pad = DashboardPadKeyboard();
				break;

			case EPadType::XBox:
			case EPadType::PlayStation:
				@m_pad = DashboardPadGamepad();
				break;
		}
	}

	void OnSettingsChanged()
	{
		if (m_pad !is null) {
			m_pad.OnSettingsChanged();
		}
		m_gearbox.OnSettingsChanged();
		m_speed.OnSettingsChanged();
		m_wheels.OnSettingsChanged();
	}

	void Render()
	{
		auto app = GetApp();

		auto sceneVis = app.GameScene;
		if (sceneVis is null) {
			return;
		}

		// Interface hidden
		if (Setting_General_HideOnHiddenInterface) {
			if (app.CurrentPlayground is null || app.CurrentPlayground.Interface is null || Dev::GetOffsetUint32(app.CurrentPlayground.Interface, 0x1C) == 0) {
				return;
			}
		}

		CSceneVehicleVis@ vis = null;

		auto player = GetViewingPlayer();
		if (player !is null) {
			@vis = Vehicle::GetVis(sceneVis, player);
		} else {
			@vis = Vehicle::GetSingularVis(sceneVis);
		}

		if (vis is null) {
			return;
		}

		if (Setting_General_ShowPad && m_pad !is null) {
			m_pad.m_pos = Setting_General_PadPos;
			m_pad.m_size = Setting_General_PadSize;
			m_pad.InternalRender(vis.AsyncState);
		}

		if (Setting_General_ShowGearbox) {
			m_gearbox.m_pos = Setting_General_GearboxPos;
			m_gearbox.m_size = Setting_General_GearboxSize;
			m_gearbox.InternalRender(vis.AsyncState);
		}

		if (Setting_General_ShowSpeed) {
			m_speed.m_pos = Setting_General_SpeedPos;
			m_speed.m_size = Setting_General_SpeedSize;
			m_speed.InternalRender(vis.AsyncState);
		}

		if (Setting_General_ShowWheels) {
			m_wheels.m_pos = Setting_General_WheelsPos;
			m_wheels.m_size = Setting_General_WheelsSize;
			m_wheels.InternalRender(vis.AsyncState);
		}
	}
}

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

	if (Setting_General_MoveSpeed) {
		Locator::Render("Speed", Setting_General_SpeedPos, Setting_General_SpeedSize);
		Setting_General_SpeedPos = Locator::GetPos();
		Setting_General_SpeedSize = Locator::GetSize();
	}

	if (Setting_General_MoveWheels) {
		Locator::Render("Overview", Setting_General_WheelsPos, Setting_General_WheelsSize);
		Setting_General_WheelsPos = Locator::GetPos();
		Setting_General_WheelsSize = Locator::GetSize();
	}
}

void OnSettingsChanged()
{
	g_dashboard.OnSettingsChanged();
}

void Main()
{
	@g_dashboard = Dashboard();

	auto app = GetApp();

	@g_font = Resources::GetFont("DroidSans.ttf");
	@g_fontBold = Resources::GetFont("DroidSans-Bold.ttf");
	@g_fontIcons = Resources::GetFont("fa-solid.ttf");

	nvg::AddFallbackFont(g_font, g_fontIcons);
	nvg::AddFallbackFont(g_fontBold, g_fontIcons);

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
				case ForcePadType::Gamepad: padType = EPadType::XBox; break;
				case ForcePadType::Keyboard: padType = EPadType::Keyboard; break;
			}

			g_dashboard.SetPad(padType);
		}

		yield();
	}
}
