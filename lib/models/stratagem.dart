class Stratagem {
  final String uuid;
  final String title;
  final String type;
  final String cost;
  final String? cost2;
  final String lore;
  final String description;
  final List<String>? descriptionList;
  final String? descriptionEnd;
  final CrudTag tag;
  final List<String>? units;

  Stratagem({
    required this.uuid,
    required this.title,
    required this.type,
    required this.cost,
    this.cost2,
    required this.lore,
    required this.description,
    required this.tag,
    this.descriptionList,
    this.descriptionEnd,
    this.units,
  });
}

class MetaData {
  final String createdBy;
  final String createdDate;
  final String lastlyModified;

  const MetaData(
    this.createdBy,
    this.createdDate,
    this.lastlyModified,
  );
}

enum CrudTag {
  create,
  update,
  delete,
  vanilla,
}

class DriveResponse {
  final String name;
  final String version;
  final String createdBy;
  final String created;
  final String lastlyModified;
  final List<Stratagem> data;

  DriveResponse(
    this.name,
    this.version,
    this.createdBy,
    this.created,
    this.lastlyModified,
    this.data,
  );
}
