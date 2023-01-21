import 'package:flutter/material.dart';
import 'package:pit02gp06/models/text_field_item.dart';
import 'package:pit02gp06/src/widgets/text_field_widget.dart';
import 'package:pit02gp06/utils/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? _dateTime;

  // Image? imagePersonal;

  @override
  Widget build(BuildContext context) {
    final nameItem = TextFieldItem(
      label: 'Nome Completo',
    );
    final phoneItem = TextFieldItem(label: 'Telefone');
    const String url = "https://cdn-icons-png.flaticon.com/512/847/847969.png";
    final dropValue = ValueNotifier('');
    final dropOptions = ['Feminino', 'Masculino', 'Não informado'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.secondaryColor,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(52.0),
        child: Column(children: [
          // IMAGEM
          Container(
            height: 125,
            width: 125,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fitWidth,
                )),
          ),
          Text(
            'Nome Exemplo',
            style: AppTextStyles.textNameProfileScreen,
          ),
          Text(
            'email@exemplo.com.br',
            style: AppTextStyles.textEmailProfileScreen,
          ),
          Text(
            'Meus dados',
            style: AppTextStyles.textButtonSecondaryBlue,
          ),
          TextFieldWidget(
            item: nameItem,
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                IconButton(
                    iconSize: 30,
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2222))
                          .then((date) {
                        setState(() {
                          _dateTime = date!;
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_month)),
                Text(_dateTime == null
                    ? 'Data de Nascimento'
                    : _dateTime.toString()),
              ],
            ),
          ),
          TextFieldWidget(
            item: phoneItem,
          ),
          ValueListenableBuilder(
              valueListenable: dropValue,
              builder: (BuildContext context, String value, _) {
                return SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: const Text('Não informado'),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (choice) =>
                          dropValue.value = choice.toString(),
                      items: dropOptions
                          .map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ))
                          .toList()),
                );
              })
        ]),
      )),
    );
  }
}
