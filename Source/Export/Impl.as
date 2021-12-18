namespace Dashboard
{
#if TMNEXT
	CSmPlayer@ ViewingPlayer()
	{
		if (g_dashboard is null) { return null; }
		return g_dashboard.GetViewingPlayer();
	}
#elif TURBO
	CGameMobil@ ViewingPlayer()
	{
		if (g_dashboard is null) { return null; }
		return g_dashboard.GetViewingPlayer();
	}
#elif MP4
	CGamePlayer@ ViewingPlayer()
	{
		if (g_dashboard is null) { return null; }
		return g_dashboard.GetViewingPlayer();
	}
#endif

	CSceneVehicleVisState@ ViewingPlayerState()
	{
		if (g_dashboard is null) { return null; }
		return g_dashboard.GetViewingPlayerState();
	}
}
