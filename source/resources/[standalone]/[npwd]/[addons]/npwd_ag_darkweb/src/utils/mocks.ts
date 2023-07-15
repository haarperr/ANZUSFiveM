import { Item } from '../../types/item';

export const MockedItems: Item[] = [
  {
    id: 1,
    label: 'VPN',
    price: 3000,
    image: '',
    stock: 3,
    item: 'vpn',
  },
  {
    id: 4,
    label: 'Hppy',
    price: 30,
    image: '',
    stock: 10,
    item: 'vpn',
  },
  ...Array.from({ length: 20 }, (_, index) => ({
    id: index + 5,
    label: `Item ${index + 1}`,
    price: Math.floor(Math.random() * 100) + 1,
    image: '',
    stock: Math.floor(Math.random() * 10) + 1,
    item: 'vpn',
  })),
];
