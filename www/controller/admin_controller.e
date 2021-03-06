note
	description: "Summary description for {ADMIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_CONTROLLER

inherit

	DEFAULT_CONTROLLER
		redefine
			initialize
		end

create
	make

feature {NONE}
	-- Settings

	initialize
		do
			layout := "admin"
			content_type := "html"
		end

feature
	-- Handlers

	handle_page (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			table: HASH_TABLE[STRING, STRING]
		do
			if attached sess.get (req, res) as u_name then
				if req.path_info.same_string ("/admin/add_user") AND NOT u_name.out.same_string ("super") then
					res.redirect_now ("/admin/index")
				else
					create table.make (2)
					table["user_name"] := u_name.out
					if u_name.out.same_string ("super") then
						table["create_user"] := "<li><a href='/admin/add_user'>Add admin</a></li>"
					else
						table["create_user"] := ""
					end

					if attached {WSF_STRING} req.path_parameter ("page") AS page and then not page.is_empty then
						output (res, renderHtml (page.string_representation, table))
					else
						output404 (req, res)
					end
				end
			else
				res.redirect_now ("/admin/login")
			end
		end

	handle_logout (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			sess.destroy(req, res)

			res.redirect_now ("/admin/login")
		end

	handle_login (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			defaultLayout: detachable STRING
		do
			if sess.is_logged_in (req, res) then
				res.redirect_now ("/admin/index")
			else
				defaultLayout := layout
				layout := "report"
				output (res, renderHtml ("login", Void))
				layout := defaultLayout
			end
		end

end
