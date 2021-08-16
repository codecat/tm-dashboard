class Dashboard
{
#if !COMPETITION
	CInputScriptPad::EPadType m_currentPadType = CInputScriptPad::EPadType(-1);

	DashboardThing@ m_pad;
	DashboardGearbox@ m_gearbox;
	DashboardWheels@ m_wheels;
	DashboardAcceleration@ m_acc;
#endif
	DashboardSpeed@ m_speed;

	Dashboard()
	{
#if !COMPETITION
		@m_gearbox = DashboardGearbox();
		@m_wheels = DashboardWheels();
		@m_acc = DashboardAcceleration();
#endif
		@m_speed = DashboardSpeed();
	}

#if TMNEXT
	CSmPlayer@ GetViewingPlayer()
	{
		auto playground = GetApp().CurrentPlayground;
		if (playground is null || playground.GameTerminals.Length != 1) {
			return null;
		}
		return cast<CSmPlayer>(playground.GameTerminals[0].GUIPlayer);
	}
#elif TURBO
	CGameMobil@ GetViewingPlayer()
	{
		auto playground = cast<CTrackManiaRace>(GetApp().CurrentPlayground);
		if (playground is null) {
			return null;
		}
		return playground.LocalPlayerMobil;
	}
#elif MP4
	CGamePlayer@ GetViewingPlayer()
	{
		auto playground = GetApp().CurrentPlayground;
		if (playground is null || playground.GameTerminals.Length != 1) {
			return null;
		}
		return playground.GameTerminals[0].GUIPlayer;
	}
#endif

#if !COMPETITION
	void ClearPad()
	{
		m_currentPadType = CInputScriptPad::EPadType(-1);
		@m_pad = null;
	}

	void SetPad(CInputScriptPad::EPadType type)
	{
		if (m_currentPadType == type) {
			return;
		}
		m_currentPadType = type;

		switch (type) {
			case CInputScriptPad::EPadType::Keyboard:
				@m_pad = DashboardPadKeyboard();
				break;

			case CInputScriptPad::EPadType::XBox:
			case CInputScriptPad::EPadType::PlayStation:
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
		m_acc.OnSettingsChanged();
#endif
		m_speed.OnSettingsChanged();
	}

	void Render()
	{
		auto app = GetApp();

		// Interface hidden
		if (Setting_General_HideOnHiddenInterface) {
			if (app.CurrentPlayground !is null && app.CurrentPlayground.Interface !is null) {
				if (Dev::GetOffsetUint32(app.CurrentPlayground.Interface, 0x1C) == 0) {
					return;
				}
			}
		}
#if !MP4
		auto sceneVis = app.GameScene;
		if (sceneVis is null) {
			return;
		}
		CSceneVehicleVis@ vis = null;
#else
		CGameScene@ sceneVis = null;
		CSceneVehicleVisInner@ vis = null;
#endif

		auto player = GetViewingPlayer();
		if (player !is null) {
			@vis = Vehicle::GetVis(sceneVis, player);
		} else {
			@vis = Vehicle::GetSingularVis(sceneVis);
		}

		if (vis is null) {
			return;
		}

#if TMNEXT
		uint entityId = Vehicle::GetEntityId(vis);
		if ((entityId & 0xFF000000) == 0x04000000) {
			// If the entity ID has this mask, then we are either watching a replay, or placing
			// down the car in the editor. So, we will check if we are currently in the editor,
			// and stop if we are.
			if (cast<CGameCtnEditorFree>(app.Editor) !is null) {
				return;
			}
		}
#endif

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

		if (Setting_General_ShowAcceleration) {
			m_acc.m_pos = Setting_General_AccelerationPos;
			m_acc.m_size = Setting_General_AccelerationSize;
			m_acc.InternalRender(vis.AsyncState);
		}
#endif

		if (Setting_General_ShowSpeed) {
			m_speed.m_pos = Setting_General_SpeedPos;
			m_speed.m_size = Setting_General_SpeedSize;
			m_speed.InternalRender(vis.AsyncState);
		}
	}
}
