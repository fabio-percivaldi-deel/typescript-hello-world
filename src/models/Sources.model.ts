import { AllowNull, AutoIncrement, Column, Comment, CreatedAt, DataType, Default, Model, PrimaryKey, Table, Unique, UpdatedAt } from 'sequelize-typescript';
import { UUIDV4 } from 'sequelize';

@Table({
  tableName: 'sources',
  underscored: true,
  indexes: []
})
export class Sources extends Model {
  @PrimaryKey
  @AllowNull(false)
  @AutoIncrement
  @Comment('Sequential primary key for the table.')
  @Column({ type: DataType.INTEGER })
  declare id: number;

  @AllowNull(false)
  @Unique
  @Default(UUIDV4)
  @Comment('Unique public uuid identifier.')
  @Column({ field: 'public_id', type: DataType.UUIDV4 })
  declare publicId: string;

  @AllowNull(false)
  @CreatedAt
  @Comment('Timestamp of when the record was created.')
  @Column({
    field: 'created_at',
    type: DataType.DATE
  })
  declare createdAt: Date;

  @AllowNull(false)
  @UpdatedAt
  @Comment('Timestamp of when the record was last updated.')
  @Column({
    field: 'updated_at',
    type: DataType.DATE
  })
  declare updatedAt: Date;

  @Unique
  @Column({
    type: DataType.STRING,
    comment: 'name of the service exposing swagger'
  })
  declare name: string;
}
