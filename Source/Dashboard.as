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
