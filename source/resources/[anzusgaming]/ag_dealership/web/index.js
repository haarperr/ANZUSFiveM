//==========| CONFIG |==========\\
const allCars = [];
let setTaxRate = 0;
let category = '';
let vehClass = '';

// DOM elements
const allVehiclesContainer = document.getElementById('allVehicles');
const mainMenu = document.getElementById('MainMenu');
const vehicleCatalogName = document.getElementById('VehicleCatalogName');

//==========| WINDOW |==========\\
window.addEventListener('message', handleMessageEvent);

function handleMessageEvent(event) {
  const callData = event.data;

  if (callData.type === 'LoadVehicles') {
    handleLoadVehicles(callData);
  }

  if (callData.type === 'UpdateTaxRate' && callData.vehicleClass === category) {
    handleUpdateTaxRate(callData);
  }
}

function handleLoadVehicles(callData) {
  allCars.push(...callData.cars);
  setTaxRate = callData.currentTax;
  category = callData.category;
  vehClass = callData.class;

  for (let i = 0; i < allCars.length; i++) {
    const newVehicleEle = createVehicleElement(allCars[i], i);
    allVehiclesContainer.append(newVehicleEle);
  }

  vehicleCatalogName.textContent = `Vehicle Catalog ( ${category} )`;
  mainMenu.style.opacity = 1;
}

function handleUpdateTaxRate(callData) {
  allVehiclesContainer.innerHTML = '';
  setTaxRate = callData.newTax;

  for (let i = 0; i < allCars.length; i++) {
    const newVehicleEle = createVehicleElement(allCars[i], i);
    allVehiclesContainer.append(newVehicleEle);
  }
}

function createVehicleElement(car, index) {
  const newVehicleEle = document.createElement('div');
  newVehicleEle.id = `vehWindow${index}`;
  newVehicleEle.style.opacity = 0;
  newVehicleEle.classList.add('purchaseVehicle');

  const imageElement = document.createElement('img');
  imageElement.src = car.image;
  imageElement.id = `ImgEle${index}`;
  imageElement.addEventListener('error', handleImageError);
  imageElement.onload = handleImageLoad.bind(null, index);
  newVehicleEle.append(imageElement);

  const title = document.createElement('h3');
  title.textContent = car.name;
  newVehicleEle.append(title);

  const vehicleFullPrice = document.createElement('h4');
  const fullPrice = car.price * (setTaxRate * 0.01) + car.price;
  vehicleFullPrice.textContent = `Price: $${fullPrice.toLocaleString()}`;
  newVehicleEle.append(vehicleFullPrice);

  const currentTaxRate = document.createElement('h4');
  currentTaxRate.textContent = `Tax Rate: ${setTaxRate}%`;
  newVehicleEle.append(currentTaxRate);

  const vehicleStock = document.createElement('h4');
  vehicleStock.textContent = `Stock: ${car.stock}`;
  newVehicleEle.append(vehicleStock);

  if (car.stock > 0) {
    const showVehicleBtn = createButton('Show Vehicle', 'rgb(178, 0, 0)', () => {
      changeDisplayVehicle(category, car.model);
    });
    newVehicleEle.append(showVehicleBtn);

    const testVehicleBtn = createButton('Test Drive', 'rgb(18, 0, 178)', () => {
      starTestDrive(car.model);
    });
    newVehicleEle.append(testVehicleBtn);

    const purchaseVehicleBtn = createButton('Purchase', 'rgb(18, 117, 0)', () => {
      const fullPrice = car.price * (setTaxRate * 0.01) + car.price;
      purchaseVehicle(fullPrice, fullPrice.toLocaleString(), car.model, category);
    });
    newVehicleEle.append(purchaseVehicleBtn);
  } else {
    const noStockVehicleBtn = createButton('Out Of Stock', 'rgb(178, 0, 0)');
    newVehicleEle.append(noStockVehicleBtn);
  }

  return newVehicleEle;
}

function createButton(text, backgroundColor, onClick) {
  const button = document.createElement('button');
  button.style.backgroundColor = backgroundColor;
  button.textContent = text;
  button.onclick = onClick;
  return button;
}

function handleImageError(event) {
  const index = parseInt(event.target.id.slice(7));
  document.getElementById(`ImgEle${index}`).src = 'images/vehicle.png';
}

function handleImageLoad(index) {
  const vehicleWindow = document.getElementById(`vehWindow${index}`);
  vehicleWindow.classList.add('showVehicle');
  setTimeout(() => {
    vehicleWindow.style.opacity = 1;
  }, 950);
}

//==========| ESC ACTION |==========\\
document.onkeyup = function (data) {
  if (data.which === 27) {
    closeMenu();
  }
};

//==========| TEST DRIVE VEHICLE |==========\\
function starTestDrive(model) {
  postData('https://ag_dealership/startTestDrive', { model });
  closeMenu();
}

//==========| CHANGE DISPLAY VEHICLE |==========\\
function changeDisplayVehicle(category, model) {
  postData('https://ag_dealership/changeDisplayVehicle', { category, model });
}

//==========| PURCHASE VEHICLE |==========\\
function purchaseVehicle(price, fullPrice, model, vehLocation) {
  postData('https://ag_dealership/purchaseVehicle', { price, fullPrice, model, vehLocation });
  closeMenu();
}

//==========| CLOSE MENU |==========\\
function closeMenu() {
  setTaxRate = 0;
  allCars.length = 0;
  postData('https://ag_dealership/exit', { class: vehClass });
  category = '';
  vehClass = '';
  allVehiclesContainer.innerHTML = '';
  mainMenu.style.opacity = 0;
}

function postData(url, data) {
  // Use appropriate method to send data to the server (e.g., fetch, Axios, jQuery.ajax)
  // Example using fetch:
  fetch(url, {
    method: 'POST',
    body: JSON.stringify(data),
  }).catch((error) => {
    // Handle error
    console.error('Error:', error);
  });
}
