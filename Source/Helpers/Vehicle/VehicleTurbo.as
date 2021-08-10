// This file contains code to access some visual information that is not normally available. This
// code isn't entirely future-proof, so it might stop working after some game updates. If you want
// to use this code keep this in mind! Use `#max_game_version` to avoid crashes on unexpected game
// updates.

#if TURBO
class CSceneVehicleVis
{
	CMwNod@ m_mobil;
	CMwNod@ m_vis;

	CSceneVehicleVisState@ AsyncState;

	CSceneVehicleVis(CMwNod@ vehicleMobil)
	{
		@m_mobil = vehicleMobil;
		@m_vis = Dev::GetOffsetNod(vehicleMobil, 0x84);

		@AsyncState = CSceneVehicleVisState(m_vis);
	}
}

class CSceneVehicleVisState
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

namespace Vehicle
{
	// Get vehicle vis from a given player.
	CSceneVehicleVis@ GetVis(CGameScene@ sceneVis, CGameMobil@ player)
	{
		if (player is null) {
			return null;
		}
		return CSceneVehicleVis(Dev::GetOffsetNod(player, 0x14));
	}

	// Get the only existing vehicle vis state, if there is only one. Otherwise, this returns null.
	CSceneVehicleVis@ GetSingularVis(CGameScene@ sceneVis)
	{
		auto playground = cast<CTrackManiaRace>(GetApp().CurrentPlayground);
		if (playground is null) {
			return null;
		}
		return GetVis(sceneVis, playground.LocalPlayerMobil);
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
	uint GetEntityId(CSceneVehicleVis@ vis)
	{
		// Not present
		return 0;
	}
}
#endif
