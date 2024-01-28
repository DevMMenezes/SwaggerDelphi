unit Models.Client;

interface

uses
  Horse,
  Horse.GBSwagger;

type
  TModelsClient = class
  private
    FID: Integer;
    FName: String;
  public
    property ID: Integer read FID;
    property Name: String read FName;

    function setID(aValue: Integer): TModelsClient;
    function setName(aValue: String): TModelsClient;
  end;

  TAPIError = class
  private
    Ferror: string;
  public
    property error: string read Ferror write Ferror;
  end;

implementation

{ TModelsClient }

function TModelsClient.setID(aValue: Integer): TModelsClient;
begin
  FID := aValue;
  Result := Self;
end;

function TModelsClient.setName(aValue: String): TModelsClient;
begin
  FName := aValue;
  Result := Self;
end;

end.
