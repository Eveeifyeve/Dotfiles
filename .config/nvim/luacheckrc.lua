return {
    globals = {
        vim = {
            read_only = true,
            fields = {
                cmd = { read_only = true },
                fn = { read_only = true, fields = { stdpath = {}, system = {} } },
                loop = { read_only = true, fields = { fs_stat = {} } },
                opt = { read_only = true, fields = { rtp = { read_only = true, fields = { prepend = {} } } } },
                api = { read_only = true, fields = { nvim_set_keymap = {} } },
                g = { read_only = false, fields = {mapleader = {}} }
                -- Add other fields as needed
            }
        }
    }
  }