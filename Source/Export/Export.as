namespace Dashboard
{
	// Gets the currently viewed player. This can be the local player or the player being spectated.
#if TMNEXT
	import CSmPlayer@ ViewingPlayer() from "Dashboard";
#elif TURBO
	import CGameMobil@ ViewingPlayer() from "Dashboard";
#elif MP4
	import CGamePlayer@ ViewingPlayer() from "Dashboard";
#endif

	// Gets the CSceneVehicleVisState handle for the currently viewed player.
	import CSceneVehicleVisState@ ViewingPlayerState() from "Dashboard";
}

namespace Vehicle
{
	// Get RPM for vehicle vis.
	import float GetRPM(CSceneVehicleVisState@ vis);

	// Get wheel dirt amount for vehicle vis. For w, use one of the following:
	//  0 = Front Left
	//  1 = Front Right
	//  2 = Rear Left
	//  3 = Rear Right
	import float GetWheelDirt(CSceneVehicleVisState@ vis, int w) from "Dashboard";

	// Get relative side speed for vehicle.
	import float GetSideSpeed(CSceneVehicleVisState@ vis) from "Dashboard";

#if TMNEXT
	// Get vehicle vis from a given player.
	import CSceneVehicleVis@ GetVis(ISceneVis@ sceneVis, CSmPlayer@ player) from "Dashboard";

	// Get the only existing vehicle vis state, if there is only one. Otherwise, this returns null.
	import CSceneVehicleVis@ GetSingularVis(ISceneVis@ sceneVis) from "Dashboard";

	// Get all vehicle vis states. Mostly used for debugging.
	import array<CSceneVehicleVis@> GetAllVis(ISceneVis@ sceneVis) from "Dashboard";
#endif
}
