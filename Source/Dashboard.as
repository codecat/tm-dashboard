class Dashboard
{
	CInputScriptPad::EPadType m_currentPadType = CInputScriptPad::EPadType(-1);

	DashboardThing@ m_pad;
	DashboardGearbox@ m_gearbox;
	DashboardWheels@ m_wheels;
	DashboardAcceleration@ m_acc;
	DashboardSpeed@ m_speed;

	Dashboard()
	{
		@m_gearbox = DashboardGearbox();
		@m_wheels = DashboardWheels();
		@m_acc = DashboardAcceleration();
		@m_speed = DashboardSpeed();
	}

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

	void OnSettingsChanged()
	{
		if (m_pad !is null) {
			m_pad.OnSettingsChanged();
		}
		m_gearbox.OnSettingsChanged();
		m_wheels.OnSettingsChanged();
		m_acc.OnSettingsChanged();
		m_speed.OnSettingsChanged();
	}

	void Render()
	{
		auto app = GetApp();

		if (Setting_General_HideWhenNotPlaying) {
			if (app.CurrentPlayground !is null && (app.CurrentPlayground.UIConfigs.Length > 0)) {
				if (app.CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::Intro) {
					return;
				}
			}
		}

		auto visState = VehicleState::ViewingPlayerState();
		if (visState is null) {
			return;
		}

		bool visiblePad          = UI::IsGameUIVisible() ? Setting_General_ShowPad          : Setting_General_ShowPadHidden;
		bool visibleGearbox      = UI::IsGameUIVisible() ? Setting_General_ShowGearbox      : Setting_General_ShowGearboxHidden;
		bool visibleWheels       = UI::IsGameUIVisible() ? Setting_General_ShowWheels       : Setting_General_ShowWheelsHidden;
		bool visibleAcceleration = UI::IsGameUIVisible() ? Setting_General_ShowAcceleration : Setting_General_ShowAccelerationHidden;
		bool visibleSpeed        = UI::IsGameUIVisible() ? Setting_General_ShowSpeed        : Setting_General_ShowSpeedHidden;

		if (visiblePad && m_pad !is null) {
			m_pad.m_pos = Setting_General_PadPos;
			m_pad.m_size = Setting_General_PadSize;
			m_pad.InternalRender(visState);
		}

		if (visibleGearbox) {
			m_gearbox.m_pos = Setting_General_GearboxPos;
			m_gearbox.m_size = Setting_General_GearboxSize;
			m_gearbox.InternalRender(visState);
		}

		if (visibleWheels) {
			m_wheels.m_pos = Setting_General_WheelsPos;
			m_wheels.m_size = Setting_General_WheelsSize;
			m_wheels.InternalRender(visState);
		}

		if (visibleAcceleration) {
			m_acc.m_pos = Setting_General_AccelerationPos;
			m_acc.m_size = Setting_General_AccelerationSize;
			m_acc.InternalRender(visState);
		}

		if (visibleSpeed) {
			m_speed.m_pos = Setting_General_SpeedPos;
			m_speed.m_size = Setting_General_SpeedSize;
			m_speed.InternalRender(visState);
		}
	}
}
