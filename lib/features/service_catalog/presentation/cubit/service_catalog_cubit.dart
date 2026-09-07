import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_service_detail.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_catalog_cubit.freezed.dart';

/// Cubit for the service catalog list (read-only, no complex events).
class ServiceCatalogCubit extends Cubit<ServiceCatalogState> {
  ServiceCatalogCubit(this._loadServices)
    : super(const ServiceCatalogState.initial());

  final LoadServices _loadServices;

  Future<void> load() async {
    emit(const ServiceCatalogState.loading());
    final result = await _loadServices();
    result.match(
      (failure) => emit(ServiceCatalogState.failure(failure)),
      (services) => emit(ServiceCatalogState.ready(services)),
    );
  }
}

@freezed
sealed class ServiceCatalogState with _$ServiceCatalogState {
  const factory ServiceCatalogState.initial() = ServiceCatalogInitial;
  const factory ServiceCatalogState.loading() = ServiceCatalogLoading;
  const factory ServiceCatalogState.ready(List<Service> services) =
      ServiceCatalogReady;
  const factory ServiceCatalogState.failure(Failure failure) =
      ServiceCatalogFailure;
}

/// Cubit for a single service detail page.
class ServiceDetailCubit extends Cubit<ServiceDetailState> {
  ServiceDetailCubit(this._loadServiceDetail)
    : super(const ServiceDetailState.initial());

  final LoadServiceDetail _loadServiceDetail;

  Future<void> load(String serviceId) async {
    emit(const ServiceDetailState.loading());
    final result = await _loadServiceDetail(serviceId);
    result.match(
      (failure) => emit(ServiceDetailState.failure(failure)),
      (detail) => emit(ServiceDetailState.ready(detail)),
    );
  }
}

@freezed
sealed class ServiceDetailState with _$ServiceDetailState {
  const factory ServiceDetailState.initial() = ServiceDetailInitial;
  const factory ServiceDetailState.loading() = ServiceDetailLoading;
  const factory ServiceDetailState.ready(ServiceDetail detail) =
      ServiceDetailReady;
  const factory ServiceDetailState.failure(Failure failure) =
      ServiceDetailFailure;
}
