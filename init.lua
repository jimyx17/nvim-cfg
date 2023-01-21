---Main configuration init flow

---STAGE 1: boot and initialize lower layer bindings and behaviour
require("user_options").setup()

-- STAGE 2: Bootstrap base plugin manager and base plugins
require("core_boot").setup()

--- STAGE 3: configure first UI interface
require("user_interface").setup()

---STAGE 4: configure the rest of plugins
require("plugin_setup").setup()
