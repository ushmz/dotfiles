local M = {}

---If the result file is bigger than a `max_size`,
---stop reading after `max_size` bytes from the head.
---@param max_size number Max file size (bytes)
---@return fun(filepath: string, bufnr: number, opts: table): nil
M.create = function(max_size)
	return function(filepath, bufnr, opts)
		opts = opts or {}
		filepath = vim.fn.expand(filepath)
		vim.loop.fs_stat(filepath, function(_, stat)
			if not stat then
				return
			end
			if stat.size > max_size then
				local cmd = { "head", "-c", max_size, filepath }
				require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
			else
				require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
			end
		end)
	end
end

return M
