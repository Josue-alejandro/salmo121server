const sortByName = (array) => {
    return array.sort((a, b) => a.name.localeCompare(b.name));
}

module.exports = {
    sortByName
}