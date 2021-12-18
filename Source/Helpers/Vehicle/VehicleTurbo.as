// This file contains code to access some visual information that is not normally available. This
// code isn't entirely future-proof, so it might stop working after some game updates. If you want
// to use this code keep this in mind! Use `#max_game_version` to avoid crashes on unexpected game
// updates.

#if TURBO
class CSceneVehicleVis
{
	CMwNod@ m_mobil;
	CMwNod@ m_vis;

	//NOTE: CSceneVehicleVisState is defined in Export/StateWrappers.as!
	CSceneVehicleVisState@ AsyncState;

	CSceneVehicleVis(CMwNod@ vehicleMobil)
	{
		@m_mobil = vehicleMobil;
		@m_vis = Dev::GetOffsetNod(vehicleMobil, 0x84);

		@AsyncState = CSceneVehicleVisState(m_vis);
	}
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
