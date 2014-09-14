module ApplicationHelper
	# Nicely formats text with line breaks and add links
	def linked_text_body(text, options = {})
		if options[:truncate]
			text = truncate(text, length: options[:truncate], separator: ' ')
		end
		auto_link(h(text).gsub(/\n/, '<br>').html_safe, html: { target: '_blank' })
	end
end
