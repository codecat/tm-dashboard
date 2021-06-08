// This file contains code to access some visual information that is not normally available. This
// code isn't entirely future-proof, so it might stop working after some game updates. If you want
// to use this code keep this in mind! Use `#max_game_version` to avoid crashes on unexpected game
// updates.

namespace Vehicle
{
	// -       ... : 5
	// - 2021-06-08: 4
	uint VehiclesManagerIndex = 4;
	uint VehiclesOffset = 0x1C8;

	bool CheckValidVehicles(CMwNod@ vehicleVisMgr)
	{
		auto ptr = Dev::GetOffsetUint64(vehicleVisMgr, VehiclesOffset);
		auto count = Dev::GetOffsetUint32(vehicleVisMgr, VehiclesOffset + 0x8);

		// Ensure this is a valid pointer
		if ((ptr & 0xF) != 0) {
			return false;
		}

		// Assume we can't have more than 1000 vehicles
		if (count > 1000) {
			return false;
		}

		return true;
	}

	// Get vehicle vis from a given player.
	CSceneVehicleVis@ GetVis(ISceneVis@ sceneVis, CSmPlayer@ player)
	{
		// When Vehicle is null, we're playing offline. In that case, we'll just grab the first entity
		// that matches the ID mask 0x02000000.
		uint vehicleEntityId = 0;
		if (player.ScriptAPI.Vehicle !is null) {
			vehicleEntityId = player.ScriptAPI.Vehicle.Id.Value;
		}

		auto vehicleVisMgr = SceneVis::GetMgr(sceneVis, VehiclesManagerIndex); // NSceneVehicleVis_SMgr
		if (vehicleVisMgr is null) {
			return null;
		}

		if (!CheckValidVehicles(vehicleVisMgr)) {
			return null;
		}

		auto vehicles = Dev::GetOffsetNod(vehicleVisMgr, VehiclesOffset);
		auto vehiclesCount = Dev::GetOffsetUint32(vehicleVisMgr, VehiclesOffset + 0x8);

		for (uint i = 0; i < vehiclesCount; i++) {
			auto nodVehicle = Dev::GetOffsetNod(vehicles, i * 0x8);
			auto nodVehicleEntityId = Dev::GetOffsetUint32(nodVehicle, 0);

			if (vehicleEntityId != 0 && nodVehicleEntityId != vehicleEntityId) {
				continue;
			} else if (vehicleEntityId == 0 && (nodVehicleEntityId & 0x02000000) == 0) {
				continue;
			}

			return Dev::ForceCast<CSceneVehicleVis@>(nodVehicle).Get();
		}

		return null;
	}

	// Get the only existing vehicle vis state, if there is only one. Otherwise, this returns null.
	CSceneVehicleVis@ GetSingularVis(ISceneVis@ sceneVis)
	{
		auto vehicleVisMgr = SceneVis::GetMgr(sceneVis, 5); // NSceneVehicleVis_SMgr
		if (vehicleVisMgr is null) {
			return null;
		}

		auto vehiclesCount = Dev::GetOffsetUint32(vehicleVisMgr, VehiclesOffset + 0x8);
		if (vehiclesCount != 1) {
			return null;
		}

		if (!CheckValidVehicles(vehicleVisMgr)) {
			return null;
		}

		auto vehicles = Dev::GetOffsetNod(vehicleVisMgr, VehiclesOffset);
		auto nodVehicle = Dev::GetOffsetNod(vehicles, 0);
		return Dev::ForceCast<CSceneVehicleVis@>(nodVehicle).Get();
	}

	// Get all vehicle vis states. Mostly used for debugging.
	array<CSceneVehicleVis@> GetAllVis(ISceneVis@ sceneVis)
	{
		array<CSceneVehicleVis@> ret;

		auto vehicleVisMgr = SceneVis::GetMgr(sceneVis, 5); // NSceneVehicleVis_SMgr
		if (vehicleVisMgr !is null && CheckValidVehicles(vehicleVisMgr)) {
			auto vehicles = Dev::GetOffsetNod(vehicleVisMgr, VehiclesOffset);
			auto vehiclesCount = Dev::GetOffsetUint32(vehicleVisMgr, VehiclesOffset + 0x8);

			for (uint i = 0; i < vehiclesCount; i++) {
				auto nodVehicle = Dev::GetOffsetNod(vehicles, i * 0x8);
				ret.InsertLast(Dev::ForceCast<CSceneVehicleVis@>(nodVehicle).Get());
			}
		}

		return ret;
	}

	// Get RPM for vehicle vis. This is contained within the state, but not exposed by default, which
	// is why this function exists.
	float GetRPM(CSceneVehicleVisState@ vis)
	{
		if (g_offsetEngineRPM == 0) {
			auto type = Reflection::GetType("CSceneVehicleVisState");
			if (type is null) {
				error("Unable to find reflection info for CSceneVehicleVisState!");
				return 0.0f;
			}
			g_offsetEngineRPM = type.GetMember("EngineOn").Offset + 4;
		}

		return Dev::GetOffsetFloat(vis, g_offsetEngineRPM);
	}

	// Get wheel dirt amount for vehicle vis. For w, use one of the following:
	//  0 = Front Left
	//  1 = Front Right
	//  2 = Rear Left
	//  3 = Rear Right
	float GetWheelDirt(CSceneVehicleVisState@ vis, int w)
	{
		if (g_offsetWheelDirt.Length == 0) {
			auto type = Reflection::GetType("CSceneVehicleVisState");
			if (type is null) {
				error("Unable to find reflection info for CSceneVehicleVisState!");
				return 0.0f;
			}
			g_offsetWheelDirt.InsertLast(type.GetMember("FLIcing01").Offset - 4);
			g_offsetWheelDirt.InsertLast(type.GetMember("FRIcing01").Offset - 4);
			g_offsetWheelDirt.InsertLast(type.GetMember("RLIcing01").Offset - 4);
			g_offsetWheelDirt.InsertLast(type.GetMember("RRIcing01").Offset - 4);
		}

		return Dev::GetOffsetFloat(vis, g_offsetWheelDirt[w]);
	}

	// Get absolute velocity for vehicle vis.
	vec3 GetVelocity(CSceneVehicleVisState@ vis)
	{
		if (g_offsetVelocity == 0) {
			auto type = Reflection::GetType("CSceneVehicleVisState");
			if (type is null) {
				error("Unable to find reflection info for CSceneVehicleVisState!");
				return vec3();
			}
			g_offsetVelocity = type.GetMember("Position").Offset + 4 * 3;
		}

		vec3 ret;
		ret.x = Dev::GetOffsetFloat(vis, g_offsetVelocity);
		ret.y = Dev::GetOffsetFloat(vis, g_offsetVelocity + 4);
		ret.z = Dev::GetOffsetFloat(vis, g_offsetVelocity + 8);
		return ret;
	}

	// Get relative side speed for vehicle.
	float GetSideSpeed(CSceneVehicleVisState@ vis)
	{
		if (g_offsetSideSpeed == 0) {
			auto type = Reflection::GetType("CSceneVehicleVisState");
			if (type is null) {
				error("Unable to find reflection info for CSceneVehicleVisState!");
				return 0.0f;
			}
			g_offsetSideSpeed = type.GetMember("FrontSpeed").Offset + 4;
		}

		return Dev::GetOffsetFloat(vis, g_offsetSideSpeed);
	}

	uint16 g_offsetEngineRPM = 0;
	array<uint16> g_offsetWheelDirt;
	uint16 g_offsetVelocity = 0;
	uint16 g_offsetSideSpeed = 0;
}
