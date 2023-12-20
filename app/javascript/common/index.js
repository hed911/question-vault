const fetchAndInject = async (url, targetId, callback = () => {}) => {
  const response = await fetch(url)
  const parsedResponse = await response.text()
  const element = document.querySelector(`#${targetId}`)
  element.innerHTML = parsedResponse
  callback()
}

const cleanHTML = targetId => {
  const element = document.querySelector(`#${targetId}`)
  element.innerHTML = ''
}

const openModal = async (url, callback = () => {}) => {
  fetchAndInject(url, "modal-container", () => {
    bootstrap
      .Modal
      .getOrCreateInstance(document.querySelector('#modal'))
      .show()
    if (callback) {
      callback()
    }
  })
}

const buildQueryString = (items, extraValues) => {
  if (!items.length) {
    return ""
  }

  items
    .forEach(i => {
      const extra = i.type === "radio" ? ":checked" : ""
      const valueById = document.querySelector(`#${i.fieldId}`)?.value
      const valueByName = document.querySelector(`[name="${i.fieldId}"]${extra}`)?.value
      i.value = valueById || valueByName
    })

  let params = items
    .filter(i => i.value !== "" && i.value !== undefined && i.value !== null)
    .map(i => `${i.fieldName}=${i.value}`)

  params = [...params, ...extraValues.map(e => `${e.key}=${e.value}`)]
  
  return "?" + params.join("&")
}

const bindSearchEvents = () => {
  const elements = [...document.querySelectorAll('.bind-search')]
  elements.forEach(e =>  setMultipleEvents(e))
}

const setMultipleEvents = element => {
  const events = ["change", "textInput", "input", "keyup"]
  events.forEach(e => element.addEventListener(e, searchData))
}