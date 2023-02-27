class DashboardThing
{
	string m_name;

	vec2 m_pos;
	vec2 m_size;

	DashboardThing(const string &in name)
	{
		m_name = name;
		UpdateProportions();
	}

	void InternalRender(CSceneVehicleVisState@ vis)
	{
		vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
		vec2 pos = m_pos * (screenSize - m_size);
		nvg::Translate(pos.x, pos.y);
		Render(vis);
		nvg::ResetTransform();
	}

	void OnSettingsChanged() {}
	void UpdateAsync() {}

	bool IsVisible(bool whenHidden) { throw("IsVisible is not implemented!"); return false; }
	void SetVisible(bool visible, bool visibleWhenHidden) { throw("SetVisible is not implemented!"); }

	void UpdateProportions() { throw("UpdateProportions is not implemented!"); }
	void SetProportions(const vec2 &in pos, const vec2 &in size) { throw("SetProportions is not implemented!"); }
	void ResetProportions() { throw("ResetProportions is not implemented!"); }

	void Render(CSceneVehicleVisState@ vis) { throw("Render is not implemented!"); }
}
