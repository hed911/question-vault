const openNew = () => {
  openModal("/question_groups/0/edit")
}

const openEdit = id => {
  openModal(`/question_groups/${id}/edit`)
}

const searchData = () => {
  const baseUrl = "/question_groups/filter"

  const items = [
    {type: "text", fieldId: "name_search", fieldName: "name"},
    {type: "radio", fieldId: "status_search", fieldName: "status"},
    {type: "radio", fieldId: "source_search", fieldName: "source"},
  ]

  const extraValues = [
    {key: "page", value: currentPage}
  ]

  const url = baseUrl + buildQueryString(items, extraValues)
  fetchAndInject(url, "table-container", () => {
    bindPaginationEvents()
    bindEditEvents()
  })
}

const bindEditEvents = () => {
  const elements = [...document.querySelectorAll(".edit-btn")]
  elements.forEach(element => {
    element.addEventListener('click', e => {
      e.preventDefault()
      openEdit(element.getAttribute('data-id'))
    })
  })
}

const initEvents = () => {
  const button = document.querySelector("#new-group-button")
  button.onclick = () => openNew()
}


let currentPage = 1
searchData()
bindSearchEvents()
initEvents()

