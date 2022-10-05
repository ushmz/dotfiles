local status1, nls = pcall(require, 'null-ls')
if (not status1) then return end

local status2, mp = pcall(require, 'mason-core.package')
if (not status2) then return end

local status3, mr = pcall(require, 'mason-registry')
if (not status3) then return end

local nls_sources = {}

for _, package in ipairs(mr.get_installed_packages()) do
  local categories = package.spec.categories[1]
  if categories == mp.Cat.Formatter then
    table.insert(nls_sources, nls.builtins.formatting[package.name])
  end
  if categories == mp.Cat.Linter then
    table.insert(nls_sources, nls.builtins.diagnostics[package.name])
  end
end

nls.setup({
  sources = nls_sources,
})
