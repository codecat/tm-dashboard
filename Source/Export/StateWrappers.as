#if MP4

shared class CSceneVehicleVisState
{
	CTrackManiaPlayer@ m_player;
	CTrackManiaScriptPlayer@ m_scriptapi;

	CSceneVehicleVisState(CTrackManiaPlayer@ player)
	{
		@m_player = player;
		@m_scriptapi = m_player.ScriptAPI;
	}

	float get_InputSteer() { if (m_scriptapi is null) { return 0; } return m_scriptapi.InputSteer; }
	float get_InputGasPedal() { if (m_scriptapi is null) { return 0; } return m_scriptapi.InputGasPedal; }
	float get_InputBrakePedal() { if (m_scriptapi is null) { return 0; } return m_scriptapi.InputIsBraking ? 1 : 0; }
	bool get_InputIsBraking() { if (m_scriptapi is null) { return false; } return m_scriptapi.InputIsBraking; }

	uint get_CurGear() { if (m_scriptapi is null) { return 0; } return m_scriptapi.EngineCurGear; }

	float get_RPM() { if (m_scriptapi is null) { return 0; } return m_scriptapi.EngineRpm; }

	float get_FrontSpeed() { if (m_scriptapi is null) { return 0; } return m_scriptapi.Speed; }
	float get_SideSpeed() { return 0; }

	vec3 get_Position() { if (m_scriptapi is null) { return vec3(); } return m_scriptapi.Position; }
	vec3 get_WorldVel() { return vec3(); }

	float get_FLWheelRot() { return 0; }
	float get_FLWheelRotSpeed() { return 0; }
	float get_FLSteerAngle() { return 0; }
	float get_FLSlipCoef() { return 0; }

	float get_FRWheelRot() { return 0; }
	float get_FRWheelRotSpeed() { return 0; }
	float get_FRSteerAngle() { return 0; }
	float get_FRSlipCoef() { return 0; }

	float get_RLWheelRot() { return 0; }
	float get_RLWheelRotSpeed() { return 0; }
	float get_RLSteerAngle() { return 0; }
	float get_RLSlipCoef() { return 0; }

	float get_RRWheelRot() { return 0; }
	float get_RRWheelRotSpeed() { return 0; }
	float get_RRSteerAngle() { return 0; }
	float get_RRSlipCoef() { return 0; }
}

#elif TURBO

shared class CSceneVehicleVisState
{
	CMwNod@ m_vis;

	CSceneVehicleVisState(CMwNod@ vis)
	{
		@m_vis = vis;
	}

	float get_InputSteer() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x8C); }
	float get_InputGasPedal() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x94); }
	float get_InputBrakePedal() { if (m_vis is null) { return 0; } return InputIsBraking ? 1 : 0; }
	bool get_InputIsBraking() { if (m_vis is null) { return false; } return Dev::GetOffsetUint32(m_vis, 0x98) == 1; }

	uint get_CurGear() { if (m_vis is null) { return 0; } return Dev::GetOffsetUint32(m_vis, 0x198); }

	float get_RPM() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x18C); }

	float get_FrontSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0xE8); }
	float get_SideSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0xEC); }

	vec3 get_Position() { if (m_vis is null) { return vec3(); } return Dev::GetOffsetVec3(m_vis, 0xC4); }
	vec3 get_WorldVel() { if (m_vis is null) { return vec3(); } return Dev::GetOffsetVec3(m_vis, 0xD0); }

	float get_FLWheelRot() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x100); }
	float get_FLWheelRotSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x104); }
	float get_FLSteerAngle() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x108); }
	float get_FLSlipCoef() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x114); }

	float get_FRWheelRot() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x124); }
	float get_FRWheelRotSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x128); }
	float get_FRSteerAngle() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x12C); }
	float get_FRSlipCoef() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x138); }

	float get_RLWheelRot() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x148); }
	float get_RLWheelRotSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x14C); }
	float get_RLSteerAngle() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x150); }
	float get_RLSlipCoef() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x15C); }

	float get_RRWheelRot() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x16C); }
	float get_RRWheelRotSpeed() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x170); }
	float get_RRSteerAngle() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x174); }
	float get_RRSlipCoef() { if (m_vis is null) { return 0; } return Dev::GetOffsetFloat(m_vis, 0x180); }
}

#endif
