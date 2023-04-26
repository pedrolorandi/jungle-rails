describe('Add to cart', () => {
  it('increments the cart count when a product is added', () => {
    cy.visit('/');

    // Get the initial cart count
    cy.get('li.nav-item.end-0 a.nav-link').then($cart => {
      const initialCartCount = parseInt($cart.text().match(/\d+/)[0]);
    
      // Find the first product and click on its "Add" button
      cy.get('button.btn').first().click({force: true})

      // Get the updated cart count
      cy.get('li.nav-item.end-0 a.nav-link').should($cart => {
        const updatedCartCount = parseInt($cart.text().match(/\d+/)[0]);
        
        // Confirm that the updated cart count is greater than the initial cart count
        expect(updatedCartCount).to.be.greaterThan(initialCartCount);
      });
    });
  });
});