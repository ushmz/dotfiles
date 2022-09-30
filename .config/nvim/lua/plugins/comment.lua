local ok, comment = pcall(require, 'Comment')
if (not ok) then return end

comment.setup({
  opleader = {
    line = '<Leader>c',
    block = '<Leader>b',
  }
})
