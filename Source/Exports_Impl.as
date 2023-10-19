uint g_InformedCurrentEntId;
uint g_InformedCurrentEntIdLastAt;

namespace Dashboard
{
	void InformCurrentEntityId(uint EntId) {
        g_InformedCurrentEntId = EntId;
        g_InformedCurrentEntIdLastAt = Time::Now;
    }
}
