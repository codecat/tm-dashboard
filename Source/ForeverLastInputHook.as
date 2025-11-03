#if FOREVER
// I couldn't find an easily accessible field in TmForever to find out the last used input device.
// We should get rid of this: it adds a lot of extra overhead, especially with high refresh rate controllers.
// But this will have to do for now until I come up with something better.. :(
namespace ForeverLastInputHook
{
	Dev::HookInfo@ g_hook;
	CInputDevice@ g_device;

	void Start()
	{
		IntPtr pMessage = Dev::FindPattern("83 85 ?? ?? ?? ?? ?? 83 7D");
		if (pMessage == 0) {
			error("Unable to find last input device hook pattern!");
			return;
		}
		@g_hook = Dev::Hook(pMessage, 2, "ForeverLastInputHook::InputDeviceMessage");
	}

	void Stop()
	{
		if (g_hook !is null) {
			Dev::Unhook(g_hook);
		}
	}

	void InputDeviceMessage(CInputDevice@ esi)
	{
		@ForeverLastInputHook::g_device = esi;
	}
}
#endif
