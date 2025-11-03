class Dashboard
{
	array<DashboardThing@> m_things;

	Dashboard()
	{
		m_things.InsertLast(DashboardPadHost());
		m_things.InsertLast(DashboardGearbox());
		m_things.InsertLast(DashboardWheels());
		m_things.InsertLast(DashboardAcceleration());
		m_things.InsertLast(DashboardSpeed());
		m_things.InsertLast(DashboardClock());
	}

	void Main()
	{
		while (true) {
			for (uint i = 0; i < m_things.Length; i++) {
				m_things[i].UpdateAsync();
			}
			yield();
		}
	}

	void OnSettingsChanged()
	{
		for (uint i = 0; i < m_things.Length; i++) {
			m_things[i].OnSettingsChanged();
		}
	}

	void Render()
	{
		auto app = GetApp();

		if (Setting_General_HideWhenNotPlaying) {
#if FOREVER
			//todo
#else
			if (app.CurrentPlayground !is null && (app.CurrentPlayground.UIConfigs.Length > 0)) {
				if (app.CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::Intro) {
					return;
				}
			}
#endif
		}

		auto visState = VehicleState::ViewingPlayerState();
		if (visState is null) {
			return;
		}

		bool gameUIVisible = UI::IsGameUIVisible();

		for (uint i = 0; i < m_things.Length; i++) {
			auto thing = m_things[i];
			if (thing.IsVisible(!gameUIVisible)) {
				thing.UpdateProportions();
				thing.InternalRender(visState);
			}
		}
	}
}
