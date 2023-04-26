describe('Product details', () => {
  it('should allow navigation to product details page', () => {
    // Visit the home page
    cy.visit('/')

    // Click on the first product's link
    cy.get('.products article').first().find('a').click()

    // Verify that the product details page is displayed
    cy.url().should('include', '/products/')
    cy.get('.product-detail').should('be.visible')
  })
})
