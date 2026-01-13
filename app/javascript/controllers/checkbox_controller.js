import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  submit(event) {
    const checkbox = event.target
    const isChecked = checkbox.checked
    
    // หา quest item container
    const questItem = checkbox.closest('.quest-item')
    if (!questItem) return
    
    // หา text element ที่จะขีดฆ่า
    const textElement = questItem.querySelector('.text-lg.font-medium')
    if (!textElement) return
    
    // Optimistic update: ขีดฆ่าหรือลบขีดฆ่าทันที
    if (isChecked) {
      textElement.classList.add('line-through', 'text-gray-400')
      textElement.classList.remove('text-gray-900')
      // เปลี่ยน border และ background
      questItem.classList.remove('border-gray-200', 'hover:border-indigo-300')
      questItem.classList.add('border-green-200', 'bg-green-50')
    } else {
      textElement.classList.remove('line-through', 'text-gray-400')
      textElement.classList.add('text-gray-900')
      // เปลี่ยน border และ background กลับ
      questItem.classList.remove('border-green-200', 'bg-green-50')
      questItem.classList.add('border-gray-200', 'hover:border-indigo-300')
    }
    
    // Submit form
    checkbox.closest('form').requestSubmit()
  }
}
