const bindPaginationEvents = () => {
  const elements = [...document.querySelectorAll('[data-page]')]
  elements.forEach(element => {
    element.addEventListener('click', e => {
      e.preventDefault()
      currentPage = parseInt(element.getAttribute("data-page"))
      searchData()
    })
  })
}