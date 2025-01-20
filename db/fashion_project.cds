namespace app.fashion_project;

using {Currency} from '@sap/cds/common';


type Flag : String(1);

entity Sections {
    key id          : UUID       @(title: 'Section ID');
        name        : String(16) @(title: 'Section name');
        description : String(64) @(title: 'Section Descrition');


}

entity Fashion_type {
    key id          : UUID                    @(title: 'Fashion type ID');
        sections    : Association to Sections @(title: 'Section ID');
        name_type   : String(16)              @(title: 'Fashion type name');
        description : String(64)              @(title: 'Fashion type Decription');

}

entity Fashion_item {
    key id           : UUID                        @(title: 'Fashion item ID');
        Fashion_type : Association to Fashion_type @(title: 'Fashion type ID');
        nameitem     : String(16)                  @(title: 'Fashion item name');
        brand        : String(16)                  @(title: 'Brand');
        size         : String(16)                  @(title: 'Size');
        price        : String(16)                  @(title: 'Price');
        material     : String(16)                  @(title: 'Material');
        currency     : Currency                    @(title: 'Currency');
        isAvailable  : Flag                        @(title: 'Is available');

}


view YC_fashionShop as
    select from Fashion_item as fItem {

        fItem.Fashion_type.sections.id   as selectionID,
        fItem.Fashion_type.sections.name as selectionName,
        fItem.Fashion_type.description   as selectionDesc,
        fItem.Fashion_type.id            as fashionTypeId,
        fItem.Fashion_type.name_type     as fashionTypeName,
        fItem.Fashion_type.description   as fashionTypeDesc,
        fItem.id                         as fashionItemId,
        fItem.nameitem                   as fashionItemName,
        fItem.brand                      as fashionItemBrand,
        fItem.size                       as fashionItemSize,
        fItem.material                   as fashionItemMaterial,
        fItem.price                      as fashionItemPrice,
        fItem.currency                   as fashionItemCurrency,
        fItem.isAvailable                as fashionisAvailable,
        concat(
            fItem.brand, concat(
                ' ', fItem.nameitem
            )
        )                                as itemDetails : String(32),
        case
            when
                fItem.price >= 500
            then
                'Premium'
            when
                fItem.price     >= 100
                and fItem.price <  500
            then
                'Mid-Range'

            else
                'Low-Range'
        end                              as priceRange  : String(10)
    }
    where
        fItem.isAvailable = 'X';



view YC_fashionType as
    select from Fashion_type as fType {
        fType.id as fashionTypeId ,
        fType.name_type AS fashionTypeName,
        fType.sections.name as sectionName
    }