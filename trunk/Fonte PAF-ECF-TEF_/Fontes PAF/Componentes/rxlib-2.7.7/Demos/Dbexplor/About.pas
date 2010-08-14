{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1997, 1998 Master-Bank              }
{                                                       }
{*******************************************************}

unit About;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, RXCtrls;

type
  TAboutDlg = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    WinVer: TLabel;
    FreeMem: TLabel;
    SecretPanel: TSecretPanel;
    Label1: TLabel;
    VersionLabel: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowAbout;

const
  SDbxVersion: string = '';

implementation

uses RxVerInf, RxConst, VclUtils;

{$R *.DFM}

procedure ShowAbout;
begin
  with TAboutDlg.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TAboutDlg.FormCreate(Sender: TObject);
const
{$IFDEF WIN32}
  sFreeMem = 'Physical memory:        %s K';
{$ELSE}
  sFreeMem = 'Available memory:       %s K';
{$ENDIF}
var
  Mem: Longint;
{$IFDEF WIN32}
  MemStatus: TMemoryStatus;
{$ENDIF}
begin
  Image1.Cursor := crHand;
  VersionLabel.Caption := Format(VersionLabel.Caption, [SDbxVersion]);
  WinVer.Caption := GetWindowsVersion;
{$IFDEF WIN32}
  MemStatus.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStatus);
  Mem := MemStatus.dwTotalPhys;
{$ELSE}
  Mem := GetFreeSpace(0);
{$ENDIF}
  FreeMem.Caption := Format(sFreeMem, [FormatFloat(',0.##',
    Mem / 1024.0)]);
end;

procedure TAboutDlg.Image1DblClick(Sender: TObject);
begin
  SecretPanel.Active := not SecretPanel.Active;
end;

const
  DefVersion = '1.6';

initialization
{$IFDEF WIN32}
  with TVersionInfo.Create(Application.ExeName) do
  try
    if Valid then
      SDbxVersion := Format('%d.%d', [FileLongVersion.All[2],
        FileLongVersion.All[1]])
    else SDbxVersion := DefVersion;
  finally
    Free;
  end;
{$ELSE}
  SDbxVersion := DefVersion;
{$ENDIF}
end.