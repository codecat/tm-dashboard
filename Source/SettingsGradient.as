class SettingsGradient
{
	[Setting name="Color 1" color]
	vec4 Color1 = vec4(0, 0, 0, 1);

	[Setting name="Color 2" color]
	vec4 Color2 = vec4(1, 1, 1, 1);

	[Setting name="Orientation" min=0 max=360]
	float Orientation;

	SettingsGradient() {} //TODO: https://www.gamedev.net/forums/topic/717099-script-builder-addon-fails-on-variable-declaration/
	SettingsGradient(const vec4 &in color1, const vec4 &in color2, float orientation = 60)
	{
		Color1 = color1;
		Color2 = color2;
		Orientation = orientation;
	}

	nvg::Paint GetPaint(const vec2 &in pos, const vec2 &in size, float alpha = 1.0f)
	{
		float rot = Math::ToRad(Orientation);
		vec2 mid = pos + size / 2;
		vec2 dir(Math::Cos(rot), Math::Sin(rot));
		float radius = Math::Max(size.x, size.y) / 2;
		vec2 start = mid + dir * radius;
		vec2 end = mid + (dir * -1) * radius;

		if (alpha < 1.0f) {
			vec4 c1 = Color1;
			c1.w *= alpha;

			vec4 c2 = Color2;
			c2.w *= alpha;

			return nvg::LinearGradient(start, end, c1, c2);
		}

		return nvg::LinearGradient(start, end, Color1, Color2);
	}
}
