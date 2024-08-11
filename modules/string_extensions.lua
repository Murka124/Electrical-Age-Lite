function string.startsWith(source, start)
    return string.sub(source,1,string.len(start))==start
end