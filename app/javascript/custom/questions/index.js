const openNew = () => {
  openModal(`/question_groups/${gon.parent_id}/questions/0/edit/`)
}

const openEdit = id => {
  openModal(`/question_groups/${gon.parent_id}/questions/${id}/edit/`)
}

const searchData = () => {
  const baseUrl = `/question_groups/${gon.parent_id}/questions/filter`

  const items = [
    {type: "text", fieldId: "query_search", fieldName: "query"},
    {type: "radio", fieldId: "status_search", fieldName: "status"},
    {type: "radio", fieldId: "source_search", fieldName: "source"},
    {type: "radio", fieldId: "difficulty_level_search", fieldName: "difficulty_level"}
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

