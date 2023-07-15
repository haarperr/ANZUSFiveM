---------------------------------------------------------------------------------------------------------------

Make sure to join the discord to recieve your customer role and get access to customer discounts and benefits! 

                                  https://discord.com/invite/UNbCJUrncS

---------------------------------------------------------------------------------------------------------------

# INSTALLATION:

1. Unzip downloaded resource from keymaster 

2. Put 'solos-restaurants' folder in resources folder (usually [standalone] folder) - ensure solos-restaurants in .cfg if necessary

3. Add images from /assets to inventory images folder 
    a. for qb-inventory --> /qb-inventory/html/images 
    b. for ox_inventory --> /ox_inventory/web/images

4. Add items to items.lua 
    a. add the items from 'items.txt' located in /solos-restaurants > /assets > items.txt to your inventory items.lua

5. Delete the esx_restaurants.sql file from the resource folder (this is only used and needed for ESX)

6. Clear cache and restart server

7. Enjoy!

# ADD JOBS FOR EACH RESTAURANT:
    1. in qb-management > qb-management.sql add the following lines after where it says "INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES"
        a. should look like this: https://i.imgur.com/MRS4VJK.png
        b. add or change as needed depending on your server's jobs
--        
        ('atom', 0, 'boss'),
        ('hornys', 0, 'boss'),
        ('pearls', 0, 'boss'),
        ('koi', 0, 'boss'),
        ('burgershot', 0, 'boss'),
        ('pizzathis', 0, 'boss'),
        ('uwu', 0, 'boss'),
--

    2. in qb-core > jobs.lua add the following jobs:
        a. you can add as many as you'd like
        b. you can add/remove/edit grades as you'd like

--
        ['atom'] = { --must match table in databse for society funds
            label = 'Up n Atom',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['hornys'] = {
            label = 'Horny\'s',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['pearls'] = {
            label = 'Pearls',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['koi'] = {
            label = 'Koi',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['burgershot'] = { 
            label = 'Burger Shot',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['pizzathis'] = {
            label = 'Pizza This',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
        ['uwu'] = {
            label = 'Uwu Cafe',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                ['0'] = {
                    name = 'cashier',
                    payment = 50
                },
                ['1'] = {
                    name = 'cook',
                    payment = 100
                },
                ['2'] = {
                    name = 'manager',
                    isboss = true,
                    payment = 150
                },
                ['3'] = {
                    name = 'owner',
                    isboss = true,
                    payment = 200
                },
            },
        },
--


# ADD NEW TARGET LOCATIONS:
    1. Cash Registers:
        a. Get the coords for the register prop and add to solos-restaurants > config.lua > config.cashregisters table https://i.imgur.com/zqRlR1S.png
        b. Get the vector3 coords for the prop: https://i.imgur.com/OOjp1Eu.jpeg 
        c. Add coords to config.cashregisters, change job to match the restaurant's job
    2. Trays: 
        a. These are used to give the customers their order
        b. Similar to cash registers, get the vector3 coords for the tray you want to make targetable 
        c. Add coords to config.trays table (https://i.imgur.com/xqwT2l6.png) - name must be unique!
    3. Cook locations:
        a. to create a new zone, use /pzcreate box command: https://i.imgur.com/8BHDiPW.png
        b. enter name for zone, input length and width, adjust position for zone: https://i.imgur.com/XkABNn6.png, https://i.imgur.com/o4n70JC.jpeg 
        c. Use /pzfinish command to save to you polyzone_created_zones.txt documented location in your framework folder: https://i.imgur.com/w1bCXtA.png
        d. copy zone information and create new table in config.locations: https://i.imgur.com/91zSyH9.png | config: https://i.imgur.com/kXzqiVD.png
        e. You can configure what type of cooking zone it is, which job can target it, and what recipes can be cooked for each zone. 


# For questions or support:

---------------------------------------------
--- https://discord.com/invite/UNbCJUrncS ---
---------------------------------------------

# More FiveM Resources:

--------------------------------
--- https://shop.solosv.com/ ---
--------------------------------

----------------------------------------------
--- CUSTOMER DISCOUNT CODE: MXFH-7HQ9-593W ---
----------------------------------------------
