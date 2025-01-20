using {app.fashion_project} from '../db/fashion_project';


service fashion_project_service {
    entity Sections             as projection on fashion_project.Sections;

    @cds.redirection.target: true
    entity Fashion_type         as projection on fashion_project.Fashion_type;

    entity Fashion_item         as projection on fashion_project.Fashion_item;
    entity srv_fashionshop      as projection on fashion_project.YC_fashionShop;
    entity serv_fashionshopType as projection on fashion_project.YC_fashionType;

}

@odata.draft.enabled
annotate fashion_project.Fashion_item with @(UI: {

    CreateHidden           : false,
    UpdateHidden           : false,
    DeleteHidden           : false,

    HeaderInfo             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Online fashion shop',
        TypeNamePlural: 'Online fashion shop',
        Title         : {Value: nameitem},
        Description   : {Value: 'Online fashion shop'}
    },
    SelectionFields        : [
        Fashion_type_id,
        nameitem,
        brand,
        size,
        price,


    ],

    LineItem               : [
        {Value: Fashion_type.sections.name},
        {
            Value: Fashion_type.name_type,
            Label: 'Fashion type'
        },
        {Value: nameitem},
        {Value: brand},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ],

    Facets                 : [
        {

            $Type : 'UI.CollectionFacet',
            ID    : '1',
            Label : 'Fashion type and Section',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#TypeSection',

            }]


        },
        {
            $Type : 'UI.CollectionFacet',
            ID    : '2',
            Label : 'Fashion Item',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#FItem',

            }]
        }

    ],

    FieldGroup #TypeSection: {Data: [
        {Value: Fashion_type_id},
        {Value: Fashion_type.name_type ,  ![@Common.FieldControl] : #ReadOnly},
        {Value: Fashion_type.description ,  ![@Common.FieldControl] : #ReadOnly},
        {Value: Fashion_type.sections.id ,  ![@Common.FieldControl] : #ReadOnly},
        {Value: Fashion_type.sections.name ,  ![@Common.FieldControl] : #ReadOnly}
    ]},
    FieldGroup #FItem      : {Data: [
        {Value: id},
        {Value: nameitem},
        {Value: brand},
        {Value: size},
        {Value: material},
        {Value: price},
        {Value: currency_code},
        {Value: isAvailable}
    ]}
});


annotate fashion_project_service.Fashion_item with {
    Fashion_type @(
        title         : 'Fashion Type',
        sap.value.list: 'fixed-values',
        Common        : {
            ValueListWithFixedValues,
            ValueList: {
                CollectionPath: 'serv_fashionshopType',
                Parameters    : [
                    {
                        $Type            : 'Common.ValueListParameterInOut',
                        ValueListProperty: 'fashionTypeId',
                        LocalDataProperty: Fashion_type_id
                    },
                    {
                        $Type            : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'sectionName'

                    },
                    {
                        $Type            : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'fashionTypeName',

                    },

                ]
            },
        }
    )
};
