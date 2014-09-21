# Create the initial 10 tiers
if Tier.blank?
	10.times do |i|
		Tier.create(name: "#{i + 1}")
	end
end

# Add some default categories just to get started
Category.create(name: "Sniper", description: "A lightly armoured robot with powerful, long-rage railguns. Weak in close-quarters combat, especially SMGs.")
Category.create(name: "Gunbed", description: "A very well armoured wheeled vehicle, normally equipped with large amounts of lasers.")
Category.create(name: "Flyer", description: "A moderately armoured winged robot, usually with several thrusters.")
Category.create(name: "Satellite", description: "A high flying robot that snipes enemies from above. Usually lightly armoured but with powerful weapons.")
Category.create(name: "Tank", description: "A wheeled or hover craft designed for ground assault. Mainly used with lasers or plasmas.")
Category.create(name: "Bomber", description: "A well armoured flying vehicle equipped with plasmas. Strong against ground vehicles, weak against SMGs and interceptors.")
Category.create(name: "Interceptor", description: "A very fast and manoeuvrable flying vehicle. Utilises front mounted SMGs to take down bombers, satellites or some ground targets.")
Category.create(name: "Funny", description: "A non-serious robot created purely for fun.")

# Create the three Robocraft weapon types
Weapon.create(name: "Subatomic Machine Gun", short_name: "smg")
Weapon.create(name: "Plasma Launcher", short_name: "plasma")
Weapon.create(name: "Rail Cannon", short_name: "rail")