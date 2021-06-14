class Dashboard
{
#if !COMPETITION
	EPadType m_currentPadType = EPadType(-1);

	DashboardThing@ m_pad;
	DashboardGearbox@ m_gearbox;
	DashboardWheels@ m_wheels;
#endif
	DashboardSpeed@ m_speed;

	Dashboard()
	{
#if !COMPETITION
		@m_gearbox = DashboardGearbox();
		@m_wheels = DashboardWheels();
#endif
		@m_speed = DashboardSpeed();
	}

	CSmPlayer@ GetViewingPlayer()
	{
		auto playground = GetApp().CurrentPlayground;
		if (playground is null || playground.GameTerminals.Length != 1) {
			return null;
		}
		return cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
	}

#if !COMPETITION
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
#endif

	void OnSettingsChanged()
	{
#if !COMPETITION
		if (m_pad !is null) {
			m_pad.OnSettingsChanged();
		}
		m_gearbox.OnSettingsChanged();
		m_wheels.OnSettingsChanged();
#endif
		m_speed.OnSettingsChanged();
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
			if (app.CurrentPlayground !is null && app.CurrentPlayground.Interface !is null) {
				if (Dev::GetOffsetUint32(app.CurrentPlayground.Interface, 0x1C) == 0) {
					return;
				}
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

		uint entityId = Dev::GetOffsetUint32(vis, 0);
		if ((entityId & 0xFF000000) == 0x04000000) {
			// If the entity ID has this mask, then we are either watching a replay, or placing
			// down the car in the editor. So, we will check if we are currently in the editor,
			// and stop if we are.
			if (cast<CGameCtnEditorFree>(app.Editor) !is null) {
				return;
			}
		}

#if !COMPETITION
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

		if (Setting_General_ShowWheels) {
			m_wheels.m_pos = Setting_General_WheelsPos;
			m_wheels.m_size = Setting_General_WheelsSize;
			m_wheels.InternalRender(vis.AsyncState);
		}
#endif

		if (Setting_General_ShowSpeed) {
			m_speed.m_pos = Setting_General_SpeedPos;
			m_speed.m_size = Setting_General_SpeedSize;
			m_speed.InternalRender(vis.AsyncState);
		}
	}
}
