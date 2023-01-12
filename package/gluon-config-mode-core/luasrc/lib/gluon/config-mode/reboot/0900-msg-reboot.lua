local site_i18n = i18n 'gluon-site'

local util = require 'gluon.util'
local site = require 'gluon.site'
local uci = require("simple-uci").cursor()
local sysconfig = require 'gluon.sysconfig'
local pretty_hostname = require 'pretty_hostname'

local selected_domain = uci:get('gluon', 'core', 'domain')
local hostname = pretty_hostname.get(uci)
local contact = uci:get_first('gluon-node-info', 'owner', 'contact')

local msg = site_i18n._translate('gluon-config-mode:reboot')
if not msg then return end

local domain_name="unknown"

for _, domain_path in ipairs(util.glob('/lib/gluon/domains/*.json')) do
	local domain_code = domain_path:match('([^/]+)%.json$')
	local domain = assert(json.load(domain_path))
	if selected_domain == domain_code then
		domain_name = domain.domain_names[selected_domain]
	end
end


renderer.render_string(msg, {
	hostname = hostname,
	site = site,
	sysconfig = sysconfig,
	domain = selected_domain,
	domainname = domain_name,
	contact = contact,
})
