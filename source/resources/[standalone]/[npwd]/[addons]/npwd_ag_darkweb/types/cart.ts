export interface Cart {
  items: CartItem[];
}

export interface CartItem {
  id: number;
  label: string;
  price: number;
  amount: number;
  item: string;
}
