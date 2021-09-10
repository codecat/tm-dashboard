class DashboardThing
{
	vec2 m_pos;
	vec2 m_size;

	void InternalRender(CSceneVehicleVisState@ vis)
	{
		vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
		vec2 pos = m_pos * (screenSize - m_size);
		nvg::Translate(pos.x, pos.y);
		Render(vis);
		nvg::ResetTransform();
	}

	void OnSettingsChanged() {}
	void Render(CSceneVehicleVisState@ vis) {}
	void Update(float dt) {}
}
