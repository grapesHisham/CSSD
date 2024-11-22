class PostUsedItemEntryModel {
    List<PostUsedItemEntryDataModel> uentry;

    PostUsedItemEntryModel({
        required this.uentry,
    });

}

class PostUsedItemEntryDataModel {
    int productId;
    String location;
    int quantity;

    PostUsedItemEntryDataModel({
        required this.productId,
        required this.location,
        required this.quantity,
    });

}
