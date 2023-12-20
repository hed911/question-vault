const openNew = () => {
  openModal("/integrations/0/edit", () => {
    const element = document.querySelector("#type")
    element.addEventListener('change', injectFormFields)
  })
}

const injectFormFields = e => {
  if (!e.target.value) {
    cleanHTML("variable-fields")
    return
  }
  fetchAndInject(`/integrations/form?type=${e.target.value}`, "variable-fields")
}

const openEdit = id => {
  openModal(`/integrations/${id}/edit`, () => {
    const element = document.querySelector("#type")
    element.addEventListener('change', injectFormFields)
  })
}

const searchData = () => {
  const baseUrl = "/integrations/filter"

  const items = [
    {type: "radio", fieldId: "status_search", fieldName: "status"},
    {type: "radio", fieldId: "source_search", fieldName: "integrable_type"},
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

