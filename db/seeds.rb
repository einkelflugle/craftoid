# Create the initial 10 tiers
10.times do |i|
	Tier.find_or_create_by_name("#{i + 1}")
end

# Add some default categories just to get started
Category.create(name: "Sniper", description: "A lightly armoured robot with powerful, long-rage railguns.")
Category.create(name: "Gunbed", description: "A very well armoured wheeled vehicle, normally equipped with large amounts of lasers.")
Category.create(name: "Flyer", description: "A moderately armoured winged robot, usually with several thrusters. Weaponry can vary.")