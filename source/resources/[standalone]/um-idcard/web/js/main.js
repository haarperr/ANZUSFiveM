import { fetchNui } from './fetchNui.js';
import { Global } from '../../lang/global.js';

let config;

function addListItems(listId, items) {
  const list = document.getElementById(listId);

  items.forEach((item) => {
    const newItem = document.createElement('li');

    item.forEach((content) => {
      const span = document.createElement('span');
      span.textContent = content.text;

      if (content.id) {
        span.id = content.id;
      }

      if (content.className) {
        span.className = content.className;
      }

      newItem.appendChild(span);
    });

    list.appendChild(newItem);
  });
}

/**
 * Get element by id
 * @param id {string}
 **/
const getElementById = (id) => document.getElementById(id);

/**
 * Set visibility
 * @param visibility {string}
 **/
const setVisibility = (visibility) => (getElementById('um-idcard').style.visibility = visibility);

/**
 * Set visibility of badge
 * @param badge {string|Object|null}
 **/
const setBadgeVisibility = (badge) => {
  const badgeElement = getElementById('badge');
  if (!badge || badge === 'none') {
    badgeElement.style.display = 'none';
    return;
  }
  getElementById('badgeimg').src = `badges/${badge.img}.png`;
  getElementById('badgegrade').textContent = badge.grade;
  badgeElement.style.display = 'flex';
};

const closeFunction = () => {
  getElementById('um-idcard').classList.remove('animate__animated', 'animate__fadeInLeft', 'animate__faster');
  setVisibility('hidden');
  setBadgeVisibility('none');
  fetchNui('closeIdCard');
};

/**
 * Open id card
 * @param playerData {Object}
 **/
const openIdCard = (playerData) => {
  const license = config.Licenses[playerData.cardtype];
  //   const elements = {
  //     lastname: playerData.lastname,
  //     name: playerData.firstname,
  //     sign: `${playerData.lastname} ${playerData.firstname}`,
  //     dob: playerData.birthdate,
  //     sex: playerData.sex,
  //     nationality: playerData.nationality,
  //     cardtype: license.header,
  //   };

  if (playerData.issuedon) {
    const date = new Date(playerData.issuedon);

    const formattedDate = date.toLocaleDateString();
    playerData.issuedon = formattedDate;
  }

  if (playerData.status) {
    const statusIndex = license.items.findIndex((item) => item[1].id === 'status');

    if (statusIndex !== -1) {
      license.items[statusIndex][1].className = playerData.status == 'INVALID' ? 'error' : 'success';
    }
  }

  const ul = document.getElementById('list');
  while (ul.firstChild) {
    ul.removeChild(ul.firstChild);
  }

  addListItems('list', license.items);
  Object.entries(Global).forEach(([key, value]) => {
    const result = key.replace(/^lang_/, '');
    if (getElementById(key)) {
      getElementById(key).textContent = value;
      if (result != 'header') getElementById(result).textContent = playerData[result];
    }
  });

  getElementById('cardtype').textContent = license.header;
  getElementById('sign').textContent = `${playerData.lastname} ${playerData.firstname}`;

  getElementById('mugshot').src = playerData.mugShot;
  getElementById('smallmugshot').src = playerData.mugShot;
  getElementById('um-idcard').style.backgroundColor = license.background;
  getElementById('um-idcard').classList.add('animate__animated', 'animate__fadeInLeft', 'animate__faster');
  setBadgeVisibility(playerData.badge);
  setVisibility('visible');
  autoClose();
};

const autoClose = () => {
  if (!config.IdCardSettings.autoClose.status) return;
  setTimeout(closeFunction, config.IdCardSettings.autoClose.time);
};

window.addEventListener('message', (event) => {
  const { type, playerData, configData } = event.data;
  if (type === 'playerData') {
    openIdCard(playerData);
  } else if (type === 'configData') {
    config = configData;
  }
});

document.addEventListener('keydown', (e) => {
  if (e.key !== config.IdCardSettings.closeKey) return;
  closeFunction();
});
