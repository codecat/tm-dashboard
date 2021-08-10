// This file contains code to access some visual information that is not normally available. This
// code isn't entirely future-proof, so it might stop working after some game updates. If you want
// to use this code keep this in mind! Use `#max_game_version` to avoid crashes on unexpected game
// updates.

#if MP4
class CSceneVehicleVisInner
{
	CTrackManiaPlayer@ m_player;

	CSceneVehicleVisState@ AsyncState;

	CSceneVehicleVisInner(CGamePlayer@ player)
	{
		@m_player = cast<CTrackManiaPlayer>(player);

		@AsyncState = CSceneVehicleVisState(m_player);
	}
}

class CSceneVehicleVisState
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

namespace Vehicle
{
	// Get vehicle vis from a given player.
	CSceneVehicleVisInner@ GetVis(CGameScene@ sceneVis, CGamePlayer@ player)
	{
		if (player is null) {
			return null;
		}
		return CSceneVehicleVisInner(player);
	}

	// Not used for anything in MP4 afaik, but keeping the interface identical.
	CSceneVehicleVisInner@ GetSingularVis(CGameScene@ sceneVis)
	{
		return null;
	}

	// Get RPM for vehicle vis. This is contained within the state, but not exposed by default, which
	// is why this function exists.
	float GetRPM(CSceneVehicleVisState@ vis)
	{
		return vis.RPM;
	}

	// Get relative side speed for vehicle.
	float GetSideSpeed(CSceneVehicleVisState@ vis)
	{
		return vis.SideSpeed;
	}

	// Get entity ID of the given vehicle vis.
	uint GetEntityId(CSceneVehicleVisInner@ vis)
	{
		// Not present
		return 0;
	}
}
#endif
